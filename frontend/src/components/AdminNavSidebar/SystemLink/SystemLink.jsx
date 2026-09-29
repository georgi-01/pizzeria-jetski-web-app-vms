import styles from "./SystemLink.module.css";
import { Link } from "react-router-dom";

function SystemLink({ to, label }) {
  return (
    <Link to={to} className={styles["system-link"]}>
      <span className={styles["system-icon"]} aria-hidden="true">
        ⚙
      </span>

      <span>{label}</span>
    </Link>
  );
}

export default SystemLink;