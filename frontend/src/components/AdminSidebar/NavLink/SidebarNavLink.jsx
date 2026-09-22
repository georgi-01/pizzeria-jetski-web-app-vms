import { NavLink } from "react-router-dom";
import styles from "./SidebarNavLink.module.css";

function SidebarNavLink({ label, icon, to }) {
  return (
    <NavLink
      to={to}
      className={({ isActive }) =>
        `${styles.button} ${isActive ? styles.active : ""}`
      }
    >
      {icon && <span className={styles.icon}>{icon}</span>}
      <span className={styles.label}>{label}</span>
    </NavLink>
  );
}

export default SidebarNavLink;
