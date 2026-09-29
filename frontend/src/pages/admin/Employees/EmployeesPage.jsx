import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function EmployeesPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Employees",
    subtitle: "Overview of Pizzeria Jetski employees",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default EmployeesPage;