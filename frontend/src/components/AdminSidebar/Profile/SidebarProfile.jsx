import styles from "./SidebarProfile.module.css";

function SidebarProfile() {
  return (
    <section className={styles.container}>
      <div className={styles.profile}>
        PJ
      </div>

      <div className={styles.info}>
        <div className={styles.pizzeria}>
          Pizzeria Jetski - Studentski Grad
        </div>

        <div className={styles.role}>
          Server Administrator
        </div>
      </div>
    </section>
  );
}

export default SidebarProfile;
