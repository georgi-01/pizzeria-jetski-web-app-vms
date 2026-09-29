import styles from "./SidebarSearch.module.css";

function SidebarSearch({
  placeholder = "Searching for ...",
  onChange,
}) {
  return (
    <div className={styles.bar}>
      <input
        type="text"
        className={styles.input}
        placeholder={placeholder}
        onChange={onChange}
      />

      <span className={styles.icon} aria-hidden="true">
        ⌕
      </span>
    </div>
  );
}

export default SidebarSearch;
