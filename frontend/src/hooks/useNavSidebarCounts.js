// components/AdminSidebar/useSidebarCounts.js
import { useEffect, useState } from "react";

export function useSidebarCounts() {
  const [counts, setCounts] = useState({});

  useEffect(() => {
    
    fetch("/api/admin/sidebar-counts")
      .then((res) => res.json())
      .then(setCounts)
      .catch(() => {});
  }, []);

  return counts;
}