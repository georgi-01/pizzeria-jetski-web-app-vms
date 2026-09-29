import styles from "./Content.module.css";

import OrdersOverview from "./components/OrdersOverview/OrdersOverview";
import RecentOrders from "./components/RecentOrders/RecentOrders";

function Content() {
  return (
      <div className={`${styles["row-layout"]}`}>
        <div className={`${styles["column-layout"]} ${styles["margin-right-15"]}`}>
          <OrdersOverview />
          <div className={styles["panel-separator"]}></div>
          <RecentOrders />
        </div>
      </div>
  );
}

export default Content;
