import AdminLayout from "../../../layouts/AdminLayout/AdminLayout";

const eyebrow = "Admin Control Panel",
  title = "Menu",
  subtitle = "Overview of Pizzeria Jetski menu items";
function MenuPage() {
  return (
    <AdminLayout eyebrow={eyebrow} title={title} subtitle={subtitle}>
      <div>
        <h1>Menu</h1>
      </div>
    </AdminLayout>
  );
}

export default MenuPage;
