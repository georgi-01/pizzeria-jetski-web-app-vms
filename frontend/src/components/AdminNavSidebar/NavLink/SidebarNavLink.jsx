import { NavLink } from "react-router-dom";
import styles from "./SidebarNavLink.module.css";

function SidebarNavLink({ label, icon, to, end = false, count = 1 }) {
  return (
    <NavLink
      to={to}
      end={end}
      className={({ isActive }) =>
        `${styles.button} ${isActive ? styles["active space-between"]: ""}`
      }
    >
          {icon && <span className={styles.icon}>{icon}</span>}
          <span className={styles.label}>{label}</span>
          {typeof count === "number" && (
          <span className={styles.badge}>{count}</span>
        )}
        
    </NavLink>
  );
}

export default SidebarNavLink;
