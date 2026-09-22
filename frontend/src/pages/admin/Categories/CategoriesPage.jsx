import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Categories",
  subtitle = "Overview of Pizzeria Jetski categories";
function CategoriesPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <h1>Categories</h1>
    </AdminLayout>
  );
}

export default CategoriesPage;