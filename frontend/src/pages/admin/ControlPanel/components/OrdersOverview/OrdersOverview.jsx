import styles from "./OrdersOverview.module.css";

function OrdersOverview() {
  return (
    <div className={styles["container"]}>
      <div className={styles["title"]}>Orders Overview</div>
      <div className={styles["note"]}>Orders during the current week</div>
    </div>
  );
}

export default OrdersOverview;
