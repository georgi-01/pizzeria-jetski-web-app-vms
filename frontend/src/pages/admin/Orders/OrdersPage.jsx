import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Orders",
  subtitle = "Overview of Pizzeria Jetski orders";
function OrdersPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Orders</h1>
    </AdminLayout>
  );
}

export default OrdersPage;