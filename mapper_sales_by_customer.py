# -*- coding: utf-8 -*-
#!/usr/bin/env python
import sys

for line in sys.stdin:
    data = line.strip().split('|')
    if len(data) == 7:
        customer_id = data[4]
        quantity = int(data[6])
        print(f"{customer_id}\t{quantity}")

