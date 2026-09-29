import styles from "./AdminSystemStatusSidebar.module.css";
import stylesStatusPanel from "./SystemStatusPanel/SystemStatusPanel.module.css";

import SystemStatusPanel from "./SystemStatusPanel/SystemStatusPanel";

function AdminSystemStatusBar() {
  return (
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
        </div>);
}

export default AdminSystemStatusBar;