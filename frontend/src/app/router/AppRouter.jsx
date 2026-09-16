import { BrowserRouter, Routes, Route } from 'react-router-dom';

import HomePage from '../../pages/Home/HomePage';
import LoginPage from '../../pages/Login/LoginPage';
import ErrorPage from '../../pages/Error/ErrorPage';
import NotFoundPage from '../../pages/NotFound/NotFoundPage';

function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/error" element={<ErrorPage />} />
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default AppRouter;
