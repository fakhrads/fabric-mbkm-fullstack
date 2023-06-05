'use client'
import React, {useMemo} from "react";
import {Table} from "./components/table";
import { ColumnDef } from '@tanstack/react-table';
import { filterFns } from "./components/filterFn";

type Item = {
  name: string;
  price: number;
  quantity: number;
 }



const Page = () => {
  const dummyData = () => {
    const items = [];
    for (let i = 0; i < 100; i++) {
      items.push({
        id: i,
        name: `Item ${i}`,
        price: 100,
        quantity: 1,
      });
    }
    return items;
  }
  const cols = useMemo<ColumnDef<Item>[]>(
    () => [
      {
        header: 'Name',
        cell: (row) => row.renderValue(),
        accessorKey: 'name',
      },
      {
        header: 'Price',
        cell: (row) => row.renderValue(),
        accessorKey: 'price',
      },
      {
        header: 'Quantity',
        cell: (row) => row.renderValue(),
        accessorKey: 'quantity',
      },
    ],
    []
   );
  return (
    <>
      <h1 className="font-bold text-base-content">Hello React!</h1>
      {console.log(filterFns.contains)}
      <div className="flex flex-col gap-2">       
        <Table data={dummyData()} columns={cols} showFooter={false} showGlobalFilter filterFn={filterFns.contains}  />
      </div>
    </>
  );
}

export default Page;