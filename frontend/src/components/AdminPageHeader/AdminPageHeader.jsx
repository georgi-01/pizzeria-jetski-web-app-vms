import styles from "./AdminPageHeader.module.css";

import AdminButton from "../AdminButton/AdminButton.jsx";

function AdminPageHeader({ eyebrow, title, subtitle }) {
  return (
    <header className={styles.header}>
      <div className={styles.text}>
        {eyebrow && <p className={styles.eyebrow}>{eyebrow}</p>}
        <h1 className={styles.title}>{title}</h1>
        {subtitle && <p className={styles.subtitle}>{subtitle}</p>}
      </div>

      <div className={styles.actions}>
        <AdminButton>System Info</AdminButton>
        <AdminButton>Activity Log</AdminButton>
      </div>
    </header>
  );
}

export default AdminPageHeader;
