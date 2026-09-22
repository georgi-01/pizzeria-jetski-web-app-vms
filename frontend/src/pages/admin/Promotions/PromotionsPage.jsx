import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Promotions",
  subtitle = "Overview of Pizzeria Jetski promotions";
function PromotionsPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Promotions</h1>
    </AdminLayout>
  );
}

export default PromotionsPage;