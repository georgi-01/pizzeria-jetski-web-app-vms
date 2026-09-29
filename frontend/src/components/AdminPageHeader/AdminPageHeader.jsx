import styles from "./AdminPageHeader.module.css";

import AdminButton from "../AdminButton/AdminButton.jsx";
import AdminStatCard from "../AdminStatCard/AdminStatCard.jsx"

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

      <div className={`${styles["row-layout"]} ${styles["margin-top-15"]}`}>
        <AdminStatCard
          label="Orders today"
          value="128"
          note="+8.4% vs yesterday"
        />
        <AdminStatCard
          label="Revenue today"
          value="€2,846"
          note="+12.1% vs yesterday"
        />
        <AdminStatCard
          label="Employees present"
          value="18 / 24"
          note="6 off shift"
        />
        <AdminStatCard
          label="Operating Status"
          value="Closed"
          note="Open: 8:00 - 22:30"
        />
      </div>
    </header>
  );
}

export default AdminPageHeader;
