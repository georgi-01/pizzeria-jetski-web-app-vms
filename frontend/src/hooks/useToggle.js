import { useState } from 'react';

export default function useToggle(init = false) {
    const [val, setVal] = useState(init);

    const toggle = () => setVal(v => !v);

    return [val, toggle];
}