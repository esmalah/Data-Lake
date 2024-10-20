# -*- coding: utf-8 -*-
#!/usr/bin/env python
import sys

for line in sys.stdin:
    line = line.strip()
    fields = line.split('|')
    if len(fields) == 7:
        product_id = fields[5]
        quantity = fields[6]
        print('{0}\t{1}'.format(product_id, quantity))

