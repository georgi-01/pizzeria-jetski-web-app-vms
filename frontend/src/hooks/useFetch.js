import { useCallback, useEffect, useState } from "react";

export default function useFetch(fetcher) {
    const [data, setData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [requestId, setRequestId] = useState(0);

    useEffect(() => {
        let cancelled = false;

        fetcher()
            .then((result) => {
                if (!cancelled) {
                    setData(result);
                }
            })
            .catch((err) => {
                if (!cancelled) {
                    setError(err);
                }
            })
            .finally(() => {
                if (!cancelled) {
                    setLoading(false);
                }
            });

        return () => {
            cancelled = true;
        };
    }, [fetcher, requestId]);

    const refetch = useCallback(() => {
        setLoading(true);
        setError(null);
        setRequestId((current) => current + 1);
    }, []);

    return {
        data,
        loading,
        error,
        refetch,
    };
}