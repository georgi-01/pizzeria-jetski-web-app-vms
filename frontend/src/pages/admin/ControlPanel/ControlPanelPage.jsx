// pages/admin/ControlPanel/ControlPanelPage.jsx
import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function ControlPanelPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Dashboard",
    subtitle: "Overview of Pizzeria Jetski operations",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default ControlPanelPage;