<?php

namespace App\Http\Controllers;

use App\Models\customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $customer= customer::all();
        return response()->json(['data' => $customer], 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
       $request->validate([
        'customer_name' => 'required',
        'cell_no' =>'required',
        'box_no' =>'required',
        'amount' =>'required',
       ]);
       $customer = new customer;
       $customer->customer_name=$request->customer_name;
       $customer->cell_no=$request->cell_no;
       $customer->box_no=$request->box_no;
       $customer->amount=$request->amount;
       $customer->save();

       return response()->json(['message'=>'coustomer added '],200);

    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, $id=null)
    {    
    //     $id = $request->input('id');
    //      $customer=rr customer::find($id);
    //      return response()->json(['data' => $customer], 200);
        //  print_r($customer);
        
        $customer= customer::find($id);
        if($customer)
        {
            return response()->json(['customer'=>$customer],200);
        }
        else
        {
            return response(['message'=>'no result founded'],404);
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(customer $customer)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request,$id)
    {
       
        $customer = Customer::find($id);
        $customer->customer_name=$request->customer_name;
        $customer->cell_no=$request->cell_no;
        $customer->box_no=$request->box_no;
        $customer->amount=$request->amount;
        $customer->save();

        return response()->json(['message'=>'coustomer added '],200);
    }

    /**
     * Remove the specified resource from storage.
     */
 // how a destroy controller in laravel    


    public function destroy($id)
    {
        $customer = customer::find($id);        
        if (!$customer) {
            return response()->json(['message' => 'Customer not found'], 404);
        }

        $customer->delete();

        return response()->json(['message' => 'Customer deleted successfully'], 200);
    }
    public function search(Request $request)
    {
        $query = $request->input('query');
        $customer = customer::where('customer_name', 'LIKE', '%'.$query.'%')
                            ->orWhere('cell_no', 'LIKE', '%'.$query.'%')
                            ->orWhere('box_no', 'LIKE', '%'.$query.'%')
                            ->orWhere('amount', 'LIKE', '%'.$query.'%')
                            ->get();
                            return response()->json(['data' => $customer], 200);
    }
}
 