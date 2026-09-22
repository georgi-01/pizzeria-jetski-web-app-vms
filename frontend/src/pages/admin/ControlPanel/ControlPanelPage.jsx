import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";
import Content from "./Content";

const eyebrow = "Admin Control Panel",
  title = "Dashboard",
  subtitle = "Overview of Pizzeria Jetski operations";
function ControlPanelPage() {
  
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <Content></Content>
    </AdminLayout>
  );
}

export default ControlPanelPage;
