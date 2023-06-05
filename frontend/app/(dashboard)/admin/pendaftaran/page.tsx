'use client'
import React, {useMemo} from "react";
import {Table} from "./components/table";
import { ColumnDef } from '@tanstack/react-table';
import { filterFns } from "./components/filterFn";

type Item = {
  nama: string;
  tanggal: number;
  do: number;
 }



const Page = () => {
  const dummyData = () => {
    const items = [];
    for (let i = 0; i < 100; i++) {
      items.push({
        id: i,
        nama: `Item ${i}`,
        tanggal: 100,
        do: 1,
      });
    }
    return items;
  }
  const cols = useMemo<ColumnDef<Item>[]>(
    () => [
      {
        header: 'Nama Mahasiswa',
        cell: (row) => row.renderValue(),
        accessorKey: 'nama',
      },
      {
        header: 'Tanggal Daftar',
        cell: (row) => row.renderValue(),
        accessorKey: 'tanggal',
      },
      {
        header: 'Action',
        cell: (row) => row.renderValue(),
        accessorKey: 'do',
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