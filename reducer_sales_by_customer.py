# -*- coding: utf-8 -*-
#!/usr/bin/env python
import sys

current_customer = None
total_quantity = 0

for line in sys.stdin:
    customer_id, quantity = line.strip().split('\t')
    quantity = int(quantity)

    if current_customer and current_customer != customer_id:
        print(f"{current_customer}\t{total_quantity}")
        total_quantity = 0

    current_customer = customer_id
    total_quantity += quantity

if current_customer:
    print(f"{current_customer}\t{total_quantity}")

