using System;
using FakeItEasy;
using Gateway.DataLayer;
using NUnit.Framework;

namespace WAP_WebService.UnitTest
{

    [TestFixture]
    public class DatabaseManagerTests
    {

        public DatabaseManager DefaultDatabaseManagerFactory(IAuditEntryRepository repo = null, ICodeRepository coderepo = null)
        {
            if (repo == null)
            {
                repo = A.Fake<IAuditEntryRepository>();
            }

            if (coderepo == null)
            {
                coderepo = A.Fake<ICodeRepository>();
                A.CallTo(() => coderepo.CheckCode(A<string>.Ignored, A<string>.Ignored)).Returns(true);
            }

            var log = A.Fake<ILog>();

            var dbman = new DatabaseManager(repo, log, coderepo);

            return dbman;
        }

        public AuditEntry DefaultAuditEntryFactory()
        {
            return new AuditEntry
            {
                State = "dbcreate",
                InitialSizeMB = "150" //Minsize
            };
        }

        [Test]
        public void CreateDB_dbmodifypassedin_StateSetToRejected()
        {
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory();
            audit.State = "dbmodify";

            sut.CreateDB(audit);

            Assert.That(audit.State == "Rejected");
        }

        [Test]
        public void CreateDB_dbcreatewithgoodparameters_StateSetToNew()
        {
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory();
            audit.State = "dbcreate";

            sut.CreateDB(audit);

            Assert.That(audit.State == "New");
        }

        [Test]
        public void CreateDB_invalidactionpassedin_StateSetToRejected()
        {
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory();
            audit.State = "badstatethatisnotexpected";

            sut.CreateDB(audit);

            Assert.That(audit.State == "Rejected");
            Assert.That(audit.Notes.Contains("Unsupported action"));
        }

        [Test]
        public void CreateDB_PassingAInitialSizeThatIsNotNumeric_StateSetToRejected()
        {
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory();
            audit.InitialSizeMB = "NotANumber";

            sut.CreateDB(audit);

            Assert.That(audit.State == "Rejected");
        }

        [Test]
        public void CreateDB_PassingAValueLessThan150_StateSetToRejected()
        {
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory();
            audit.InitialSizeMB = "0";

            sut.CreateDB(audit);

            Assert.That(audit.State == "Rejected");
        }

        [TestCase("DataCentre")]
        [TestCase("SQLVersion")]
        [TestCase("Zone")]
        [TestCase("Compute")]
        [TestCase("Colation")]
        [TestCase("TDE")]
        [TestCase("Environment")]
        [TestCase("Storage")]
        [TestCase("Retention")]
        [TestCase("Recovery")]
        public void CreateDB_PassingValuesThatDontMatchCodeTable_StateSetToRejected(string code)
        {
            var coderepo = A.Fake<ICodeRepository>();
            var audit = DefaultAuditEntryFactory();
            var sut = DefaultDatabaseManagerFactory(coderepo: coderepo);
            A.CallTo(() => coderepo.CheckCode(A<string>.Ignored, A<string>.Ignored)).Returns(true);
            A.CallTo(() => coderepo.CheckCode(code, A<string>.Ignored)).Returns(false);
            
            sut.CreateDB(audit);

            Assert.That(audit.State == "Rejected");
            Assert.That(audit.Notes.Contains(code));
        }

        [TestCase(1)]
        [TestCase(10)]
        [TestCase(50)]
        [TestCase(98)]
        public void CreateDB_WhenDBNameIsInUse_DBWillBeNameNextFreeNameStartingwith01(int qty)
        {
            var expectedb = "DB" + (qty + 1).ToString("00");
            var repo = A.Fake<IAuditEntryRepository>();
            var sut = DefaultDatabaseManagerFactory(repo: repo);
            var audit = DefaultAuditEntryFactory();
            audit.DBName = "DB";
            A.CallTo(() => repo.DBExist("DB")).Returns(true);
            for (var i = 0; i < qty + 1; i++)
                A.CallTo(() => repo.DBExist("DB" + i.ToString("00"))).Returns(true);

            sut.CreateDB(audit);

            Assert.That(audit.DBName == expectedb);
        }

        [Test]
        public void CreateDB_WhenDBNameIsInUsePasses100_WillThrow()
        {
            var repo = A.Fake<IAuditEntryRepository>();
            var sut = DefaultDatabaseManagerFactory(repo: repo);
            var audit = DefaultAuditEntryFactory();
            audit.DBName = "DB";
            A.CallTo(() => repo.DBExist("DB")).Returns(true);
            for (var i = 0; i < 100; i++)
                A.CallTo(() => repo.DBExist("DB" + i.ToString("00"))).Returns(true);

            Assert.Throws<ApplicationException>(() => sut.CreateDB(audit));
        }

        [Test]
        public void GetAuditStatus_CallingMethod_CallsRepository()
        {
            var auditrepo = A.Fake<IAuditEntryRepository>();
            var sut = DefaultDatabaseManagerFactory(repo: auditrepo);

            sut.GetAuditStatus("mydb");

            A.CallTo(() => auditrepo.GetAuditEntry("mydb")).MustHaveHappened();
        }

        [Test]
        public void GetCodeValue_CallingMethod_CallsRepository()
        {
            var coderepo = A.Fake<ICodeRepository>();
            var sut = DefaultDatabaseManagerFactory(coderepo: coderepo);

            sut.GetCodeValues("myvalue");

            A.CallTo(() => coderepo.GetCode("myvalue")).MustHaveHappened();
        }

        [Test]
        public void DeleteDB_CallingMethod_CallsRepository()
        {
            var repo = A.Fake<IAuditEntryRepository>();
            var sut = DefaultDatabaseManagerFactory(repo: repo);

            sut.DeleteDB("mydb");

            A.CallTo(() => repo.ScheduleDelete("mydb")).MustHaveHappened();
        }
    }
}
