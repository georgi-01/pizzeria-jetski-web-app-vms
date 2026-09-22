import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Ingredients",
  subtitle = "Overview of Pizzeria Jetski ingredients";
function IngredientsPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Ingredients</h1>
    </AdminLayout>
  );
}

export default IngredientsPage;