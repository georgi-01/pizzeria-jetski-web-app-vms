import styles from "./SystemStatusRow.module.css";


function SystemStatusRow({ label, status }) {
  return (
    <div className={styles.row}>
      <div className={styles.label}><div className={styles.orangeDot}></div>{label}</div>
      <div className={styles.status}>{status}</div>
    </div>
  );
}

export default SystemStatusRow;