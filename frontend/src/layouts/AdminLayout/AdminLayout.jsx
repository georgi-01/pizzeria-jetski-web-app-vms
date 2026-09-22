import styles from "./AdminLayout.module.css";

import AdminSidebar from "../../components/AdminSidebar/AdminSidebar";
import AdminPageHeader from "../../components/AdminPageHeader/AdminPageHeader";

function AdminLayout({ eyebrow, title, subtitle, children }) {
  return (
    <div className={styles.layout}>
      <AdminSidebar />
      
      <main className={styles.content}><AdminPageHeader eyebrow={eyebrow} title={title} subtitle={subtitle} />{children}</main>
    </div>
  );
}

export default AdminLayout;
