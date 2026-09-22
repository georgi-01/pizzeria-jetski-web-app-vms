import styles from "./RecentOrders.module.css";

function RecentOrders() {
  return (
    <div className={styles["container"]}>
      <div className={styles["title"]}>Recent Orders</div>
      <div className={styles["note"]}>Latest activity</div>
      <div className={styles["tableWrapper"]}>
        <table className={styles["table-container"]}>
          <thead className={styles["table-header"]}>
            <tr>
              <th>ORDER</th>
              <th>PREPARATION TIME</th>
              <th>STATUS</th>
              <th>TOTAL</th>
            </tr>
          </thead>
          <tbody className={styles["table-body"]}>
            <tr>
              <td>#PJ-1048</td>
              <td>12 min</td>
              <td>Completed</td>
              <td>€31.50</td>
            </tr>
            <tr>
              <td>#PJ-1047</td>
              <td>18 min</td>
              <td>Preparing</td>
              <td>€24.00</td>
            </tr>
            <tr>
              <td>#PJ-1046</td>
              <td>8 min</td>
              <td>Pending</td>
              <td>€18.50</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default RecentOrders;
