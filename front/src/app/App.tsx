import React from 'react';
import { AppProviders } from './providers/AppProviders';
import { AppNavigator } from './navigation/AppNavigator';

export default function App() {
  return (
    <AppProviders>
      <AppNavigator />
    </AppProviders>
  );
}
