import AdminButton from "../../../components/AdminButton/AdminButton";
import { useAdminHeader } from "../../../layouts/AdminLayout/AdminHeaderContext";
import Content from "./Content";

function IngredientsPage() {
  useAdminHeader({
    eyebrow: "Admin Control Panel",
    title: "Ingredients",
    subtitle: "Overview of Pizzeria Jetski ingredients",
    actions: (
      <>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </>
    ),
  });

  return <Content />;
}

export default IngredientsPage;