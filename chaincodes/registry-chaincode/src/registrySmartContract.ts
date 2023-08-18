/*
 * SPDX-License-Identifier: Apache-2.0
 */
// Deterministic JSON.stringify()
import {Context, Contract, Info, Returns, Transaction} from 'fabric-contract-api';
import stringify from 'json-stringify-deterministic';
import sortKeysRecursive from 'sort-keys-recursive';
import { Pendaftaran } from './registry';
var moment = require('moment');
interface QueryPersetujuan {
  selector: {
    persetujuanId: string;
  };
}

interface QueryString {
  selector: {
    nim: string;
  };
}

interface QueryByMitra {
  selector: {
    mitraId: string;
  };
}
@Info({title: 'RegistrySmartContract', description: 'Smart contract for registry MBKM'})
export class PendaftaranSmartContract extends Contract {
    
    // CreateAsset issues a new asset to the world state with given details.
    @Transaction()
    public async CreateAsset(ctx: Context, id: string, nim: string, nama: string, id_persetujuan_prodi: string, file: string, program: string, persetujuan: string): Promise<any> {
        const exists = await this.AssetExists(ctx, id);
        if (exists) {
            throw new Error(`The asset ${id} already exists`);
        }

        const asset: Pendaftaran = {
            id: id,
            mitraId: "",
            persetujuanId: id_persetujuan_prodi,
            nim: nim,
            nama: nama,
            file: file,
            program: program,
            persetujuan: persetujuan,
            selesai: "false",
            selesai_laporan: "false",
            created_at: moment().format(),
            updated_at: moment().format(),
        };

        // we insert data in alphabetic order using 'json-stringify-deterministic' and 'sort-keys-recursive'
        await ctx.stub.putState(id, Buffer.from(stringify(sortKeysRecursive(asset))));
        const idTrx = ctx.stub.getTxID()
        return {"status":"success","idTrx":idTrx,"message":`Pendaftaran Berhasil`}
    }

    // ReadAsset returns the asset stored in the world state with given id.
    @Transaction(false)
    public async ReadAsset(ctx: Context, id: string): Promise<string> {
        const assetJSON = await ctx.stub.getState(id); // get the asset from chaincode state
        if (!assetJSON || assetJSON.length === 0) {
            throw new Error(`The asset ${id} does not exist`);
        }
        return assetJSON.toString();
    }

    @Transaction(false)
    public async QueryByMitra(ctx: Context, id_mitra: string): Promise<any> {

        try {

            const queryString: QueryByMitra = {
              selector: {
                mitraId: id_mitra,
              },
            };


            let iterator =  await ctx.stub.getQueryResult(JSON.stringify(queryString));
            let data = await this.filterQueryData(iterator);
            
            return JSON.parse(data);
        } catch (error) {
            console.log("error", error);
            return error;
        }
    }

    @Transaction(false)
    public async QueryByPersetujuanID(ctx: Context, id_persetujuan_prodi: string): Promise<any> {

        try {

            const queryString: QueryPersetujuan = {
              selector: {
                persetujuanId: id_persetujuan_prodi,
              },
            };


            let iterator =  await ctx.stub.getQueryResult(JSON.stringify(queryString));
            let data = await this.filterQueryData(iterator);
            
            return JSON.parse(data);
        } catch (error) {
            console.log("error", error);
            return error;
        }
    }

    @Transaction(false)
    public async QueryAsset(ctx: Context, nim: string): Promise<any> {

        try {

            const queryString: QueryString = {
              selector: {
                nim: nim,
              },
            };


            let iterator =  await ctx.stub.getQueryResult(JSON.stringify(queryString));
            let data = await this.filterQueryData(iterator);
            
            return JSON.parse(data);
        } catch (error) {
            console.log("error", error);
            return error;
        }
    }

    async filterQueryData(iterator){
        const allResults = [];
        while (true) {
            const res = await iterator.next();

            if (res.value && res.value.value.toString()) {
                const Key = res.value.key;
                let Record;
                try {
                    Record = JSON.parse(res.value.value.toString('utf8'));
                } catch (err) {
                    Record = res.value.value.toString('utf8');
                }
                allResults.push({ Key, Record });
            }
            if (res.done) {
                await iterator.close();
                return JSON.stringify(allResults);
            }
        }
    }

    @Transaction()
    async UpdateMitra(ctx: Context, assetID: string, id_mitra: string): Promise<any> {
        const exists = await this.AssetExists(ctx, assetID);
        if (!exists) {
            throw new Error(`Aset dengan ID ${assetID} tidak ditemukan.`);
        }

        const assetBuffer = await ctx.stub.getState(assetID);
        const asset = JSON.parse(assetBuffer.toString());

        asset.mitraId = id_mitra;

        await ctx.stub.putState(assetID, Buffer.from(JSON.stringify(asset)));
        const idTrx = ctx.stub.getTxID();
        return {"status":"success","idTrx":idTrx,"message":`Update Kolom Mitra Berhasil`}
    }

    @Transaction()
    async UpdateStatusLaporan(ctx: Context, assetID: string, newStatus: string): Promise<any> {
        const exists = await this.AssetExists(ctx, assetID);
        if (!exists) {
            throw new Error(`Aset dengan ID ${assetID} tidak ditemukan.`);
        }

        const assetBuffer = await ctx.stub.getState(assetID);
        const asset = JSON.parse(assetBuffer.toString());

        asset.selesai_laporan = newStatus;

        await ctx.stub.putState(assetID, Buffer.from(JSON.stringify(asset)));
        const idTrx = ctx.stub.getTxID();
        return {"status":"success","idTrx":idTrx,"message":`Update Status Laporan Berhasil`}
    }

    @Transaction()
    async UpdateStatusMBKM(ctx: Context, assetID: string, newStatus: string): Promise<any> {
        const exists = await this.AssetExists(ctx, assetID);
        if (!exists) {
            throw new Error(`Aset dengan ID ${assetID} tidak ditemukan.`);
        }

        const assetBuffer = await ctx.stub.getState(assetID);
        const asset = JSON.parse(assetBuffer.toString());

        asset.selesai = newStatus;

        await ctx.stub.putState(assetID, Buffer.from(JSON.stringify(asset)));
        const idTrx = ctx.stub.getTxID();
        return {"status":"success","idTrx":idTrx,"message":`Update Status Pendaftaran & File IPFS Berhasil`}
    }

    @Transaction()
    async UpdateStatus(ctx: Context, assetID: string, newStatus: string, file: string): Promise<any> {
        const exists = await this.AssetExists(ctx, assetID);
        if (!exists) {
            throw new Error(`Aset dengan ID ${assetID} tidak ditemukan.`);
        }

        const assetBuffer = await ctx.stub.getState(assetID);
        const asset = JSON.parse(assetBuffer.toString());

        asset.persetujuan = newStatus;
        asset.file = file;
        asset.updated_at = moment().format();

        await ctx.stub.putState(assetID, Buffer.from(JSON.stringify(asset)));
        const idTrx = ctx.stub.getTxID();
        return {"status":"success","idTrx":idTrx,"message":`Update Status Pendaftaran & File IPFS Berhasil`}
    }

    // UpdateAsset updates an existing asset in the world state with provided parameters.
    @Transaction()
    public async UpdateAsset(ctx: Context, id: string, id_mitra: string, id_persetujuan_prodi: string, nim: string, nama: string, file: string, program: string, persetujuan: string, selesai_laporan: string, selesai: string, created_at: string): Promise<any> {
        
      const exists = await this.AssetExists(ctx, id);
        if (!exists) {
            throw new Error(`The asset ${id} does not exist`);
        }

        // overwriting original asset with new asset
        const updatedAsset: Pendaftaran = {
            id: id,
            mitraId: id_mitra,
            persetujuanId: id_persetujuan_prodi,
            nim: nim,
            nama: nama,
            file: file,
            program: program,
            persetujuan: persetujuan,
            selesai: selesai,
            selesai_laporan: selesai_laporan,
            created_at: created_at,
            updated_at: moment().format(),
        };

        // we insert data in alphabetic order using 'json-stringify-deterministic' and 'sort-keys-recursive'
        await ctx.stub.putState(id, Buffer.from(stringify(sortKeysRecursive(updatedAsset))));
        const idTrx = ctx.stub.getTxID();
        return {"status":"success","idTrx":idTrx,"message":`Update Pendaftaran Berhasil`}
    }

    // DeleteAsset deletes an given asset from the world state.
    @Transaction()
    public async DeleteAsset(ctx: Context, id: string): Promise<void> {
        const exists = await this.AssetExists(ctx, id);
        if (!exists) {
            throw new Error(`The asset ${id} does not exist`);
        }
        return ctx.stub.deleteState(id);
    }

    // AssetExists returns true when asset with given ID exists in world state.
    @Transaction(false)
    @Returns('boolean')
    public async AssetExists(ctx: Context, id: string): Promise<boolean> {
        const assetJSON = await ctx.stub.getState(id);
        return assetJSON && assetJSON.length > 0;
    }

    // GetAllAssets returns all assets found in the world state.
    @Transaction(false)
    @Returns('string')
    public async GetAllAssets(ctx: Context): Promise<string> {
        const allResults = [];
        // range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
        const iterator = await ctx.stub.getStateByRange('', '');
        let result = await iterator.next();
        while (!result.done) {
            const strValue = Buffer.from(result.value.value.toString()).toString('utf8');
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push(record);
            result = await iterator.next();
        }
        return JSON.stringify(allResults);
    }

}