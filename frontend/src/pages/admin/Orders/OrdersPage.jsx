import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function OrdersPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Orders",
    subtitle: "Overview of Pizzeria Jetski orders",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default OrdersPage;