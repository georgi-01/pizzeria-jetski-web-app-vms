import styles from "./AdminButton.module.css";

function AdminButton({ children, onClick }) {
  return (
    <button className={styles.button} type="button" onClick={onClick}>
      {children}
    </button>
  );
}

export default AdminButton;