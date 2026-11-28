#!/usr/bin/env python3
"""Compare a Play earnings CSV with a same-scope settlement control total.

Usage: python3 scripts/play-earnings-reconcile.py earnings.csv GHS 351.27
Use the original English headers. Supply a single statement and the independent
total for that statement and currency. Payout timing, withholding and adjustments
can cause a difference. This read-only tool prints no order or customer data.
"""
import argparse
import csv
from collections import defaultdict
from decimal import Decimal, InvalidOperation, localcontext
import re
import sys


def money(value):
    if not re.fullmatch(r"-?[0-9]{1,24}(?:\.[0-9]{1,12})?", value):
        raise ValueError("Invalid decimal amount")
    return Decimal(value)


def reconcile(path, currency, expected):
    with open(path, "rb") as source:
        encoding = "utf-16" if source.read(2) in (b"\xff\xfe", b"\xfe\xff") else "utf-8-sig"
    totals = defaultdict(Decimal)
    rows = 0
    with open(path, newline="", encoding=encoding) as source, localcontext() as ctx:
        ctx.prec = 60
        reader = csv.DictReader(source)
        columns = ("Transaction Type", "Merchant Currency", "Amount (Merchant Currency)")
        headers = reader.fieldnames or []
        if any(headers.count(key) != 1 for key in columns):
            raise ValueError("Missing or duplicate earnings report columns")
        for row in reader:
            if None in row or any(row[key] is None for key in columns):
                raise ValueError(f"Malformed row at line {reader.line_num}")
            if row["Merchant Currency"] != currency:
                continue
            kind = row["Transaction Type"].strip()
            if not kind:
                raise ValueError(f"Missing transaction type at line {reader.line_num}")
            totals[kind] += money(row["Amount (Merchant Currency)"])
            rows += 1
        if not rows:
            raise ValueError("No report rows in the requested currency")
        total = sum(totals.values())
        for kind, amount in sorted(totals.items()):
            print(f"{kind}: {currency} {amount:f}")
        print(f"{rows} rows; statement {total:f}; control {expected:f}; difference {total - expected:f}")
        return 0 if total == expected else 1


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report")
    parser.add_argument("currency")
    parser.add_argument("control_total")
    args = parser.parse_args()
    try:
        if not re.fullmatch("[A-Z]{3}", args.currency):
            raise ValueError("Use an uppercase three-letter currency code")
        sys.exit(reconcile(args.report, args.currency, money(args.control_total)))
    except (OSError, ValueError, InvalidOperation, csv.Error) as error:
        parser.exit(2, f"{error}\n")
