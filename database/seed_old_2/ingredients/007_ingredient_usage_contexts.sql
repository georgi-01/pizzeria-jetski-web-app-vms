INSERT INTO ingredient_usage_contexts (
    ingredient_id,
    usage_context_id
)
SELECT
    i.id,
    uc.id
FROM ingredients i
JOIN usage_contexts uc ON
    (i.code = 'MOZ'  AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'CHED' AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'PAR'  AND uc.name IN ('Pizza', 'Pasta', 'Salad'))

 OR (i.code = 'HAM'  AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'PEP'  AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'BAC'  AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'CHK'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta', 'Lunch Box'))
 OR (i.code = 'BEEF' AND uc.name IN ('Pizza', 'Appetizer', 'Pasta', 'Lunch Box'))

 OR (i.code = 'TOM'  AND uc.name IN ('Pizza', 'Salad', 'Pasta', 'Lunch Box'))
 OR (i.code = 'ONI'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Lunch Box'))
 OR (i.code = 'BEP'  AND uc.name IN ('Pizza', 'Salad', 'Pasta', 'Lunch Box'))
 OR (i.code = 'MUS'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta', 'Lunch Box'))
 OR (i.code = 'OLV'  AND uc.name IN ('Pizza', 'Salad', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'JAL'  AND uc.name IN ('Pizza', 'Appetizer', 'Lunch Box'))
 OR (i.code = 'CORN' AND uc.name IN ('Pizza', 'Salad', 'Lunch Box'))
 OR (i.code = 'GAR'  AND uc.name IN ('Pizza', 'Sauce', 'Pasta', 'Dough'))

 OR (i.code = 'PIN'  AND uc.name IN ('Pizza', 'Dessert', 'Lunch Box'))

 OR (i.code = 'TUN'  AND uc.name IN ('Pizza', 'Salad', 'Pasta', 'Lunch Box'))

 OR (i.code = 'TSA'  AND uc.name IN ('Pizza', 'Pasta', 'Sauce', 'Lunch Box'))
 OR (i.code = 'GSA'  AND uc.name IN ('Pizza', 'Appetizer', 'Sauce', 'Lunch Box'))
 OR (i.code = 'BBQ'  AND uc.name IN ('Pizza', 'Appetizer', 'Sauce', 'Lunch Box'))

 OR (i.code = 'SAL'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta', 'Dough'))
 OR (i.code = 'BPEP' AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta'))
 OR (i.code = 'PAP'  AND uc.name IN ('Pizza', 'Appetizer', 'Pasta'))

 OR (i.code = 'ORE'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta'))
 OR (i.code = 'BAS'  AND uc.name IN ('Pizza', 'Salad', 'Pasta'))

 OR (i.code = 'FLR'  AND uc.name = 'Dough')
 OR (i.code = 'YST'  AND uc.name = 'Dough')
 OR (i.code = 'OIL'  AND uc.name IN ('Pizza', 'Appetizer', 'Salad', 'Pasta', 'Dough'))

 OR (i.code = 'SUG'  AND uc.name IN ('Dessert', 'Dough'))
ON CONFLICT DO NOTHING;
