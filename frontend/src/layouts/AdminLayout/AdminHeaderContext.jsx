// layouts/AdminLayout/AdminHeaderContext.jsx
import { createContext, useContext, useEffect, useState } from "react";

const AdminHeaderContext = createContext(null);

export function AdminHeaderProvider({ children }) {
  const [header, setHeader] = useState({});
  return (
    <AdminHeaderContext.Provider value={{ header, setHeader }}>
      {children}
    </AdminHeaderContext.Provider>
  );
}

export function useAdminHeaderContext() {
  return useContext(AdminHeaderContext);
}

export function useAdminHeader(header) {
  const { setHeader } = useAdminHeaderContext();
  
  useEffect(() => {
    setHeader(header);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
}