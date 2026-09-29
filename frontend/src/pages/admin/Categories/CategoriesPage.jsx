import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function CategoriesPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Categories",
    subtitle: "Overview of Pizzeria Jetski categories",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default CategoriesPage;