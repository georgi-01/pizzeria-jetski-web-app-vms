import styles from "./Content.module.css";
import stylesStatusPanel from "../../../components/AdminSystemStatus/SystemStatusPanel/SystemStatusPanel.module.css";

import AdminStatCard from "./components/AdminStatCard/AdminStatCard";
import OrdersOverview from "./components/OrdersOverview/OrdersOverview";
import RecentOrders from "./components/RecentOrders/RecentOrders";
import SystemStatusPanel from "../../../components/AdminSystemStatus/SystemStatusPanel/SystemStatusPanel";

function Content() {
  return (
    <>
      <div className={styles["row-layout"]}>
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

      <div className={`${styles["row-layout"]} ${styles["margin-top-15"]}`}>
        <div className={`${styles["column-layout"]} ${styles["margin-right-15"]}`}>
          <OrdersOverview />
          <div className={styles["panel-separator"]}></div>
          <RecentOrders />
        </div>

        <div className={`${styles["column-layout"]} ${stylesStatusPanel["status-panel"]}`}>
          <SystemStatusPanel
            title="System status"
            subtitle="Core services"
            items={[
              { label: "Database", status: "Connected" },
              { label: "Backend", status: "Running" },
              { label: "Frontend", status: "Running" },
              { label: "WebSocket", status: "On" },
              { label: "Nginx", status: "Running" },
              { label: "Local DNS", status: "Active" },
            ]}
          />
          <div className={stylesStatusPanel["status-panel-separator"]}></div>
          <SystemStatusPanel
            title="Devices"
            subtitle="System workstations"
            items={[
              { label: "Server", status: "Online" },
              { label: "Manager PC", status: "Online" },
              { label: "Kitchen 1 - Manage PC", status: "Online" },
              { label: "Kitchen 2 - View Orders PC", status: "Online" },
              { label: "Carry-Out PC", status: "Online" },
              { label: "Customer Simulator PC", status: "Online" },
            ]}
          />
        </div>
      </div>
    </>
  );
}

export default Content;
