import styles from "./AdminSidebar.module.css";

import SidebarProfile from "./Profile/SidebarProfile";
import SidebarSearch from "./Search/SidebarSearch";
import SidebarNavButton from "./NavLink/SidebarNavLink";
import SidebarDivider from "./Divider/SidebarDivider";
import SystemLink from "./SystemLink/SystemLink";

function AdminSidebar() {
  const pathname = window.location.pathname;
  return (
    <aside className={styles.container}>
      <div className={styles.content}>
        <SidebarProfile />
        <div className={styles.search}>
          <SidebarSearch />
        </div>
        <nav className={styles.navigation}>
          <SidebarNavButton to="/controlpanel/categories" label="Categories" />
          <SidebarNavButton
            to="/controlpanel/ingredients"
            label="Ingredients"
          />
          <SidebarNavButton to="/controlpanel/inventory" label="Inventory" />
          <SidebarNavButton to="/controlpanel/menu" label="Menu" />
          <SidebarNavButton to="/controlpanel/orders" label="Orders" />
          <SidebarNavButton to="/controlpanel/promotions" label="Promotions" />
          <SidebarNavButton to="/controlpanel/employees" label="Employees" />
        </nav>
        <SidebarDivider />
        
        {pathname !== "/controlpanel" &&
          <nav className={styles.navigation}>
            <SidebarNavButton to="/controlpanel" label="Control Panel" />
          </nav>
        }
        
        <SystemLink to="/controlpanel/system" label="System Configuration" />
      </div>
    </aside>
  );
}

export default AdminSidebar;
