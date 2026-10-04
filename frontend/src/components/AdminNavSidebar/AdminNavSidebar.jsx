import styles from "./AdminNavSidebar.module.css";

import SidebarProfile from "./Profile/SidebarProfile";
import SidebarSearch from "./Search/SidebarSearch";
import SidebarNavLink from "./NavLink/SidebarNavLink";
import SidebarDivider from "./Divider/SidebarDivider";
import SystemLink from "./SystemLink/SystemLink";

import useFetch from "../../hooks/useFetch";
import { getCategoriesCount } from "../../services/admin/categories.service";
import { getIngredientsCount } from "../../services/admin/ingredients.service";
import { getEmployeesCount } from "../../services/admin/employees.service";

function AdminSidebar() {
  const pathname = window.location.pathname;

  const {
    data: categoriesCount,
    loading: categoriesLoading,
    error: categoriesError,
  } = useFetch(getCategoriesCount);

  const {
        data: ingredientsCount,
        loading: ingredientsLoading,
        error: ingredientsError,
    } = useFetch(getIngredientsCount);

    const {
        data: employeesCount,
        loading: employeesLoading,
        error: employeesError,
    } = useFetch(getEmployeesCount);

  return (
    <aside className={styles.container}>
      <div className={styles.content}>
        <SidebarProfile />
        <div className={styles.search}>
          <SidebarSearch />
        </div>
        <nav className={styles.navigation}>
          <SidebarNavLink
            to="/controlpanel/categories"
            label="Categories"
            count={categoriesCount?.count ?? 0}
          />
          <SidebarNavLink to="/controlpanel/ingredients" label="Ingredients" count={ingredientsCount?.count ?? 0} />
          <SidebarNavLink to="/controlpanel/inventory" label="Inventory" />
          <SidebarNavLink to="/controlpanel/menu" label="Menu" />
          <SidebarNavLink to="/controlpanel/orders" label="Orders" />
          <SidebarNavLink to="/controlpanel/promotions" label="Promotions" />
          <SidebarNavLink to="/controlpanel/employees" label="Employees" count={employeesCount?.count ?? 0} />
        </nav>
        <SidebarDivider />

        {pathname !== "/controlpanel" && (
          <nav className={styles.navigation}>
            <SidebarNavLink to="/controlpanel" label="Control Panel" />
          </nav>
        )}

        <SystemLink to="/controlpanel/system" label="System Configuration" />
      </div>
    </aside>
  );
}

export default AdminSidebar;
