import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Inventory",
  subtitle = "Overview of Pizzeria Jetski inventory";
function InventoryPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Inventory</h1>
    </AdminLayout>
  );
}

export default InventoryPage;