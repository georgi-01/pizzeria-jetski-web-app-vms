import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function PromotionsPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Promotions",
    subtitle: "Overview of Pizzeria Jetski promotions",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default PromotionsPage;