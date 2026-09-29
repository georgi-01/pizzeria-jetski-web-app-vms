import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function InventoryPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Inventory",
    subtitle: "Overview of Pizzeria Jetski inventory",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default InventoryPage;