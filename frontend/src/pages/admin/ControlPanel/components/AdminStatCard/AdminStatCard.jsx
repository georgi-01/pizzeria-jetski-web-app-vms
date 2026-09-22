import styles from "./AdminStatCard.module.css";

function AdminStatCard({ label, value, note }) {
  return (
    <div className={styles.card}>
      <div className={styles.label}>{label}</div>
      <div className={styles.value}>{value}</div>
      <div className={styles.note}>{note}</div>
    </div>
  );
}

export default AdminStatCard;