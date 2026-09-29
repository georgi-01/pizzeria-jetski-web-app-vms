import { BrowserRouter, Routes, Route } from "react-router-dom";

("Admin pages");
import AdminLayout from "../../layouts/AdminLayout/AdminLayout";
import ControlPanelPage from "../../pages/admin/ControlPanel/ControlPanelPage";
import CategoriesPage from "../../pages/admin/Categories/CategoriesPage";
import IngredientsPage from "../../pages/admin/Ingredients/IngredientsPage";
import InventoryPage from "../../pages/admin/Inventory/InventoryPage";
import MenuPage from "../../pages/admin/Menu/MenuPage";
import OrdersPage from "../../pages/admin/Orders/OrdersPage";
import PromotionsPage from "../../pages/admin/Promotions/PromotionsPage";
import EmployeesPage from "../../pages/admin/Employees/EmployeesPage";
import SystemPage from "../../pages/admin/System/SystemPage";

("Employee pages");
("To be added");

("Manager pages");
("To be added");

("Public pages");
import HomePage from "../../pages/public/Home/HomePage";
import LoginPage from "../../pages/public/Login/LoginPage";
import ErrorPage from "../../pages/public/Error/ErrorPage";
import NotFoundPage from "../../pages/public/NotFound/NotFoundPage";

function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/controlpanel" element={<AdminLayout />}>
          <Route index element={<ControlPanelPage />} />
          <Route path="categories" element={<CategoriesPage />} />
          <Route path="ingredients" element={<IngredientsPage />} />
          <Route path="inventory" element={<InventoryPage />} />
          <Route path="menu" element={<MenuPage />} />
          <Route path="orders" element={<OrdersPage />} />
          <Route path="promotions" element={<PromotionsPage />} />
          <Route path="employees" element={<EmployeesPage />} />
          <Route path="system" element={<SystemPage />} />
        </Route>

        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/error" element={<ErrorPage />} />
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default AppRouter;
