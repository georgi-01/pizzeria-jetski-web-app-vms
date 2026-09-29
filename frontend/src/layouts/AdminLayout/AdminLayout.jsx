// layouts/AdminLayout/AdminLayout.jsx
import styles from "./AdminLayout.module.css";
import AdminSidebar from "../../components/AdminNavSidebar/AdminNavSidebar";
import AdminPageHeader from "../../components/AdminPageHeader/AdminPageHeader";
import { Outlet } from "react-router-dom";
import AdminStatusSystemSidebar from "../../components/AdminSystemStatusSidebar/AdminSystemStatusSidebar";
import { AdminHeaderProvider, useAdminHeaderContext} from "./AdminHeaderContext";

function AdminLayoutShell() {
  const { header } = useAdminHeaderContext();

  return (
    <div className={styles.layout}>
      <AdminSidebar />
      <main className={styles.content}>
        <AdminPageHeader {...header} />
        <div className={styles["row"]}>
          <Outlet />
        <AdminStatusSystemSidebar />
        </div>
        
      </main>
    </div>
  );
}

function AdminLayout() {
  return (
    <AdminHeaderProvider>
      <AdminLayoutShell />
    </AdminHeaderProvider>
  );
}

export default AdminLayout;
