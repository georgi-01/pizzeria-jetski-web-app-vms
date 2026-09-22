import styles from "./SystemStatusPanel.module.css";
import SystemStatusRow from "./SystemStatusRow/SystemStatusRow";

function SystemStatusPanel({ title, subtitle, items }) {
  return (
    <div>
      <div className={styles.title}>{title}</div>
      <div className={styles.subtitle}>{subtitle}</div>
      {items.map((item) => (
        <SystemStatusRow key={item.label} label={item.label} status={item.status} />
      ))}
    </div>
  );
}

export default SystemStatusPanel;
