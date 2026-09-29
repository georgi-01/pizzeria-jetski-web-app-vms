import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function MenuPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Menu",
    subtitle: "Overview of Pizzeria Jetski menu",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default MenuPage;
