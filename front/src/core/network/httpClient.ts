import { ENV } from '../config/env';
import { SecureStorage } from '../storage/SecureStorage';
import { ApiError } from './ApiError';

interface RequestOptions extends RequestInit {
  timeoutMs?: number;
}

/**
 * Universal HTTP Client with auto Bearer Token inject & error parsing
 */
class HttpClient {
  private baseUrl: string = ENV.API_BASE_URL;

  private async getAuthHeader(): Promise<Record<string, string>> {
    const token = await SecureStorage.getItem('AUTH_TOKEN');
    if (token) {
      return { Authorization: `Bearer ${token}` };
    }
    return {};
  }

  private async request<T>(endpoint: string, options: RequestOptions = {}): Promise<T> {
    const { timeoutMs = ENV.TIMEOUT_MS, headers, ...customConfig } = options;
    const url = endpoint.startsWith('http') ? endpoint : `${this.baseUrl}${endpoint}`;

    const authHeaders = await this.getAuthHeader();

    const config: RequestInit = {
      ...customConfig,
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        ...authHeaders,
        ...headers,
      },
    };

    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeoutMs);
    config.signal = controller.signal;

    try {
      const response = await fetch(url, config);
      clearTimeout(timeoutId);

      let responseData: any;
      const contentType = response.headers.get('content-type');
      if (contentType && contentType.includes('application/json')) {
        responseData = await response.json();
      } else {
        responseData = await response.text();
      }

      if (!response.ok) {
        const errorMessage =
          (typeof responseData === 'object' && responseData?.message) ||
          (typeof responseData === 'string' && responseData) ||
          `Error de red: ${response.status} ${response.statusText}`;

        throw new ApiError(errorMessage, response.status, responseData);
      }

      return responseData as T;
    } catch (error: any) {
      clearTimeout(timeoutId);
      if (error instanceof ApiError) {
        throw error;
      }
      if (error.name === 'AbortError') {
        throw new ApiError('La solicitud ha superado el tiempo de espera (Timeout)', 408);
      }
      throw new ApiError(error.message || 'No se pudo conectar con el servidor', 500);
    }
  }

  public get<T>(endpoint: string, options?: RequestOptions): Promise<T> {
    return this.request<T>(endpoint, { ...options, method: 'GET' });
  }

  public post<T>(endpoint: string, body?: any, options?: RequestOptions): Promise<T> {
    return this.request<T>(endpoint, {
      ...options,
      method: 'POST',
      body: body ? JSON.stringify(body) : undefined,
    });
  }

  public put<T>(endpoint: string, body?: any, options?: RequestOptions): Promise<T> {
    return this.request<T>(endpoint, {
      ...options,
      method: 'PUT',
      body: body ? JSON.stringify(body) : undefined,
    });
  }

  public delete<T>(endpoint: string, options?: RequestOptions): Promise<T> {
    return this.request<T>(endpoint, { ...options, method: 'DELETE' });
  }
}

export const httpClient = new HttpClient();
