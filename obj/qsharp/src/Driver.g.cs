//------------------------------------------------------------------------------
// <auto-generated>                                                             
//     This code was generated by a tool.                                       
//     Changes to this file may cause incorrect behavior and will be lost if    
//     the code is regenerated.                                                 
// </auto-generated>                                                            
//------------------------------------------------------------------------------
#pragma warning disable 436
#pragma warning disable 162
#pragma warning disable 1591
using System;
using Microsoft.Quantum.Core;
using Microsoft.Quantum.Intrinsic;
using Microsoft.Quantum.Intrinsic.Interfaces;
using Microsoft.Quantum.Simulation.Core;

[assembly: CallableDeclaration("{\"Kind\":{\"Case\":\"Operation\"},\"QualifiedName\":{\"Namespace\":\"Quantum.Bell\",\"Name\":\"run\"},\"Attributes\":[{\"TypeId\":{\"Case\":\"Value\",\"Fields\":[{\"Namespace\":\"Microsoft.Quantum.Core\",\"Name\":\"EntryPoint\",\"Range\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]}}]},\"TypeIdRange\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]},\"Argument\":{\"Item1\":{\"Case\":\"UnitValue\"},\"Item2\":[],\"Item3\":{\"Case\":\"UnitType\"},\"Item4\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Item5\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":12},\"Item2\":{\"Line\":1,\"Column\":14}}]}},\"Offset\":{\"Item1\":4,\"Item2\":4},\"Comments\":{\"OpeningComments\":[],\"ClosingComments\":[]}}],\"Modifiers\":{\"Access\":{\"Case\":\"DefaultAccess\"}},\"SourceFile\":\"C:\\\\Users\\\\tseni\\\\Documents\\\\Quantum\\\\Bell\\\\Driver.qs\",\"Position\":{\"Item1\":5,\"Item2\":4},\"SymbolRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":14}},\"ArgumentTuple\":{\"Case\":\"QsTuple\",\"Fields\":[[]]},\"Signature\":{\"TypeParameters\":[],\"ArgumentType\":{\"Case\":\"UnitType\"},\"ReturnType\":{\"Case\":\"UnitType\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}}},\"Documentation\":[]}")]
[assembly: SpecializationDeclaration("{\"Kind\":{\"Case\":\"QsBody\"},\"TypeArguments\":{\"Case\":\"Null\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}},\"Parent\":{\"Namespace\":\"Quantum.Bell\",\"Name\":\"run\"},\"Attributes\":[],\"SourceFile\":\"C:\\\\Users\\\\tseni\\\\Documents\\\\Quantum\\\\Bell\\\\Driver.qs\",\"Position\":{\"Item1\":5,\"Item2\":4},\"HeaderRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":14}},\"Documentation\":[]}")]
#line hidden
namespace Quantum.Bell
{
    [SourceLocation("C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs", OperationFunctor.Body, 6, -1)]
    public partial class run : Operation<QVoid, QVoid>, ICallable
    {
        public run(IOperationFactory m) : base(m)
        {
        }

        String ICallable.Name => "run";
        String ICallable.FullName => "Quantum.Bell.run";
        public static EntryPointInfo<QVoid, QVoid> Info => new EntryPointInfo<QVoid, QVoid>(typeof(run));
        protected ICallable Length__
        {
            get;
            set;
        }

        protected ICallable<(Int64,Result), (Int64,Int64)> BellTest__
        {
            get;
            set;
        }

        protected ICallable<String, QVoid> Message__
        {
            get;
            set;
        }

        public override Func<QVoid, QVoid> __Body__ => (__in__) =>
        {
#line 8 "C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs"
            var initials = (IQArray<Result>)new QArray<Result>(Result.Zero, Result.One);
#line 10 "C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs"
            foreach (var idx in new QRange(0L, (initials.Length - 1L)))
#line hidden
            {
#line 11 "C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs"
                var res = BellTest__.Apply((1000L, initials[idx]));
#line 13 "C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs"
                var (numZeros,numOnes) = res;
#line 15 "C:\\Users\\tseni\\Documents\\Quantum\\Bell\\Driver.qs"
                Message__.Apply(String.Format("Init:{0} 0s={1} 1s={2}", initials[idx], numZeros, numOnes));
            }

#line hidden
            return QVoid.Instance;
        }

        ;
        public override void __Init__()
        {
            this.Length__ = this.__Factory__.Get<ICallable>(typeof(global::Microsoft.Quantum.Core.Length<>));
            this.BellTest__ = this.__Factory__.Get<ICallable<(Int64,Result), (Int64,Int64)>>(typeof(BellTest));
            this.Message__ = this.__Factory__.Get<ICallable<String, QVoid>>(typeof(global::Microsoft.Quantum.Intrinsic.Message));
        }

        public override IApplyData __DataIn__(QVoid data) => data;
        public override IApplyData __DataOut__(QVoid data) => data;
        public static System.Threading.Tasks.Task<QVoid> Run(IOperationFactory __m__)
        {
            return __m__.Run<run, QVoid, QVoid>(QVoid.Instance);
        }
    }
}