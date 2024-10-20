# -*- coding: utf-8 -*-
#!/usr/bin/env python
import sys

current_product = None
current_total = 0

for line in sys.stdin:
    line = line.strip()
    product_id, quantity = line.split('\t')
    try:
        quantity = int(quantity)
    except ValueError:
        continue

    if current_product == product_id:
        current_total += quantity
    else:
        if current_product is not None:
            print('{0}\t{1}'.format(current_product, current_total))
        current_product = product_id
        current_total = quantity

if current_product is not None:
    print('{0}\t{1}'.format(current_product, current_total))
