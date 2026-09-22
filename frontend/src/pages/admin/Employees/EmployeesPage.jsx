import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Employees",
  subtitle = "Overview of Pizzeria Jetski employees";
function EmployeesPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Employees</h1>
    </AdminLayout>
  );
}

export default EmployeesPage;